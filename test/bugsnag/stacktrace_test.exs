defmodule Bugsnag.StacktraceTest do
  use ExUnit.Case
  alias Bugsnag.Stacktrace

  test "gets current stacktrace" do
    {stacktrace, line} = {Stacktrace.current(), __ENV__.line}
    {this_fn, this_fn_arity} = __ENV__.function

    assert [{__MODULE__, ^this_fn, ^this_fn_arity,
             [file: 'test/bugsnag/stacktrace_test.exs', line: ^line]}
            | _rest] = stacktrace
  end

  test "get last exception stacktrace" do
    try do
      raise ArgumentError
    rescue
      _e -> nil
    end
    stack_line = __ENV__.line - 4
    this_module = __MODULE__
    {this_fn, this_fn_arity} = __ENV__.function

    last_stacktrace = Stacktrace.last_exception()

    assert [{^this_module, ^this_fn, ^this_fn_arity,
             [file: 'test/bugsnag/stacktrace_test.exs', line: ^stack_line]}
            | _rest] = last_stacktrace
  end

end
