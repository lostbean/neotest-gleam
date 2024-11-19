local async = require("neotest.async")
local lib = require("neotest.lib")

local GleamAdapter = {}

-- Metadata for the adapter
GleamAdapter.name = "neotest-gleam"

-- Check if this adapter can run tests in a given file
function GleamAdapter.is_test_file(file_path)
	return vim.endswith(file_path, "_test.gleam")
end

-- Discover tests in the file
function GleamAdapter.discover_positions(path)
	local query = [[
    (function_definition
      name: (identifier) @test.name
      (#match? @test.name "_test()")
    )
  ]]
	return lib.treesitter.parse_positions(path, query, { nested_namespaces = true })
end

-- Build the command to run the tests
function GleamAdapter.build_spec(args)
	local test_cmd = { "gleam", "test" }
	if args.tree:data().type == "test" then
		table.insert(test_cmd, "--filter")
		table.insert(test_cmd, args.tree:data().name)
	end
	return {
		command = table.concat(test_cmd, " "),
		cwd = args.tree:data().path,
	}
end

-- Parse test results
function GleamAdapter.results(spec, result)
	local output = result.output
	local success_pattern = "%[PASS%]%s+(%w+)"
	local fail_pattern = "%[FAIL%]%s+(%w+)"

	local results = {}
	for test_name in string.gmatch(output, success_pattern) do
		results[test_name] = { status = "passed" }
	end
	for test_name in string.gmatch(output, fail_pattern) do
		results[test_name] = { status = "failed" }
	end

	return results
end

return GleamAdapter
