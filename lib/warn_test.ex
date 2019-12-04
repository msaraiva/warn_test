defmodule FuncFromText do
  defmacro create_funcs() do
    file = "lib/funcs.txt"
    funcs = File.read!(file) |> String.split("\n") |> Enum.with_index(1)
    {funcs, errors} = Enum.split_with(funcs, fn {name, _} -> name != "error" end)

    for {func, line} <- errors do
      message = "function name #{inspect(func)} not allowed"

      # This goes to stderr and to diagnostics
      # IO.warn(message, [{:elixir_compiler, :__FILE__, 1, [file: 'lib/warn_test.ex', line: line]}])

      # This only goes to stderr
      IO.warn(message, [{:elixir_compiler, :__FILE__, 1, [file: String.to_charlist(file), line: line]}])
    end

    for {func, _line} <- funcs do
      quote do
        @external_resource unquote(file)

        def unquote(String.to_atom(func))() do
          unquote(func)
        end
      end
    end
  end
end

defmodule WarnTest do
  require FuncFromText
  FuncFromText.create_funcs()
end

