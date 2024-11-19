# neotest-gleam

A [Neotest](https://github.com/nvim-neotest/neotest) adapter for [Gleam](https://gleam.run) tests.

## Features

- Discovers and runs Gleam tests
- Parses test results with pass/fail status
- Supports running individual test files or entire test suites
- Treesitter-based test detection

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "nvim-neotest/neotest",
  dependencies = {
    -- ... other adapters ...
    "lostbean/neotest-gleam",
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-gleam"),
      },
    })
  end,
}
```

## Requirements

- Neovim >= 0.7
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
- [neotest](https://github.com/nvim-neotest/neotest)
- [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [Gleam](https://gleam.run) installed and in your PATH

## Configuration

The adapter works out of the box without any configuration. It detects Gleam projects by looking for a `gleam.toml` file.

## Usage

The adapter provides the standard Neotest commands:

- `:Neotest run` - Run the nearest test
- `:Neotest run file` - Run current file
- `:Neotest summary` - Toggle summary window
- `:Neotest output` - Toggle output window

## License

MIT

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
