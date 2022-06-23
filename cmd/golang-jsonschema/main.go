package main

import (
	"bufio"
	"fmt"
	"os"

	"github.com/jrbeverly/golang-jsonschema/pkg/apis/example.io/v1alpha"
)

func loadFile(filename string) ([]byte, error) {
	file, err := os.Open(filename)

	if err != nil {
		return nil, err
	}
	defer file.Close()

	stats, statsErr := file.Stat()
	if statsErr != nil {
		return nil, statsErr
	}

	var size int64 = stats.Size()
	bytes := make([]byte, size)

	bufr := bufio.NewReader(file)
	_, err = bufr.Read(bytes)

	return bytes, err
}

func yamlCase(filepath string) {
	data, err := loadFile(filepath)
	if err != nil {
		os.Exit(1)
	}

	toolchain := v1alpha.ToolchainPlatformInfo{}
	toolchain.UnmarshalBinaryFromYAML(data)

	fmt.Println("YAML")
	fmt.Println(toolchain.Executable)
	fmt.Println(toolchain.URL)
}

func jsonCase(filepath string) {
	data, err := loadFile(filepath)
	if err != nil {
		os.Exit(1)
	}

	toolchain := v1alpha.ToolchainPlatformInfo{}
	toolchain.UnmarshalBinary(data)

	fmt.Println("JSON")
	fmt.Println(toolchain.Executable)
	fmt.Println(toolchain.URL)
}

func main() {
	yaml := os.Args[1]
	json := os.Args[2]

	jsonCase(json)
	yamlCase(yaml)
}
