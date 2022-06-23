workspace(name = "bazel-external-toolchain-rules")

load("//:bazel/rules/deps.bzl", "bazel_dependencies")

bazel_dependencies()

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")
load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")
load("//:bazel/go/deps.bzl", "go_dependencies")

# gazelle:repository_macro bazel/go/deps.bzl%go_dependencies
go_dependencies()

go_rules_dependencies()

go_register_toolchains(version = "1.18")

gazelle_dependencies()

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load("@rules_toolchains//:defs.bzl", "register_external_toolchains")

register_external_toolchains(
    name = "external_toolchains",
    toolchains = {
        "//:bazel/toolchains/swagger.toolchain": "bazel_toolchain_swagger",
    },
)

load("@external_toolchains//:deps.bzl", "install_toolchains")

install_toolchains()
