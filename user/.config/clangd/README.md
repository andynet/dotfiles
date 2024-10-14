There are 4 tools of interest in clang.
- clang         (compiler)
- clangd        (language server)
- clang-tidy    (linter)
- clang-format  (formatter)

Unfortunatelly, their configuration is retarded.

Clang uses CLI arguments and seems not to have dedicated config file.
To make some more permanent decisions use Makefile.

Clangd is configured by:
user configuration:     ~/.config/clangd/config.yaml.
project configuration:  $PROJECT/.clangd
Clangd can be connected to neovim, and this setup then provides
autocompletions, diagnostics, and formatting.
Formatting seems to be the same as clang-format.
I would expect the diagnostics to be the same as clang-tidy,
since it claims to use that in the background,
but this is not true.

Clang-tidy strictly(!!!) requires compile_flags.txt or compile_commands.json
in the working directory, and does not read clangd config at all.
Further configuration is in $PROJECT/.clang-tidy.

Clang-format can be configured using $PROJECT/.clang-format.

