_CONTENT_PREFIX = """#!/usr/bin/env bash

# --- begin runfiles.bash initialization v2 ---
# Copy-pasted from the Bazel Bash runfiles library v2.
set -uo pipefail; f=bazel_tools/tools/bash/runfiles/runfiles.bash
source "${RUNFILES_DIR:-/dev/null}/$f" 2>/dev/null || \\
 source "$(grep -sm1 "^$f " "${RUNFILES_MANIFEST_FILE:-/dev/null}" | cut -f2- -d' ')" 2>/dev/null || \\
 source "$0.runfiles/$f" 2>/dev/null || \\
 source "$(grep -sm1 "^$f " "$0.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \\
 source "$(grep -sm1 "^$f " "$0.exe.runfiles_manifest" | cut -f2- -d' ')" 2>/dev/null || \\
 { echo>&2 "ERROR: cannot find $f"; exit 1; }; f=; set -e
# --- end runfiles.bash initialization v2 ---

# Export RUNFILES_* envvars (and a couple more) for subprocesses.
runfiles_export_envvars

"""

def _swagger_gen_impl(ctx):
    swagger = ctx.toolchains["@bazel_toolchain_swagger//:toolchain_type"].toolinfo
    executable = swagger.tool
    
    runfiles = ctx.runfiles(files = [ctx.file.spec])
    runfiles = runfiles.merge(ctx.attr._bash_runfiles[DefaultInfo].default_runfiles)

    output_dir = "$BUILD_WORKSPACE_DIRECTORY/%s" % ctx.attr.output

    cmd_mkdir = " ".join([
        "mkdir",
        "-p",
        output_dir
    ])

    cmd_exec = " ".join([
        "exec",
        "./%s" % executable.short_path,
        "generate",
        "model",
        "--spec=%s" % ctx.file.spec.short_path,
        "--target=%s" % output_dir,
    ] + ctx.attr.parameters)

    command_exec = " ".join([cmd_exec] + ['"$@"'] )

    out_file = ctx.actions.declare_file(ctx.label.name + ".bash")
    ctx.actions.write(
        output = out_file,
        content = "\n".join([_CONTENT_PREFIX, cmd_mkdir, command_exec]),
        is_executable = True,
    )

    runfiles = runfiles.merge(ctx.runfiles(files = [executable]))

    return [
        DefaultInfo(
            files = depset([]),
            runfiles = runfiles,
            executable = out_file,
        ),
    ]

swagger_gen = rule(
    implementation = _swagger_gen_impl,
    attrs = {
        "spec": attr.label(
            allow_single_file = True
        ),
        "parameters": attr.string_list(),
        "output": attr.string(
            mandatory = True,
        ),
        "_bash_runfiles": attr.label(
            default = Label("@bazel_tools//tools/bash/runfiles"),
        ),
    },
    toolchains = [
        "@bazel_toolchain_swagger//:toolchain_type",
    ],
    executable = True,
)
