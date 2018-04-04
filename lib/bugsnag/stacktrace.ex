defmodule Bugsnag.Stacktrace do
  @moduledoc """
  Retrieve stacktrace of caller function
  """

  def current do
    {:current_stacktrace, stacktrace} = Process.info(self(), :current_stacktrace)
    [_process_info | [_this_function | caller_stacktrace]] = stacktrace

    caller_stacktrace
  end

  def last_exception do
    System.stacktrace()
  end
end
