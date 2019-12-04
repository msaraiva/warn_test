# WarnTest

## The problem

Open an `iex -S mix` session and compile the project using `Mix.Task`:

```
Mix.Task.rerun("compile.elixir", ["--force"])
```

The warning is reported correctly in the stderr but is not sent to the diagnostics returning `{:ok, []}`:

```
Compiling 1 file (.ex)
warning: function name "error" not allowed
  lib/funcs.txt:3: (file)

{:ok, []}
```

# Expected behaviour

Since `funcs.txt` is an external resource interpreted by a macro, the warning should be returned
by `Mix.Task.run` so tools like VS Code that use the diagnostics (intead of the output) can
propely report the warning and also quick jump to the file/line when double clicking the warning.
