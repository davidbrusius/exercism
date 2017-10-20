defmodule SecretHandshake do
  use Bitwise

  @handshakes [
    %{ code: 1, secret: "wink" },
    %{ code: 2, secret: "double blink" },
    %{ code: 4, secret: "close your eyes" },
    %{ code: 8, secret: "jump" }
  ]

  @reverse_code 16

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(number :: integer) :: list(String.t())
  def commands(code) do
    code
    |> filter_handshakes
    |> get_secrets
  end

  defp filter_handshakes(code) do
    Enum.filter(@handshakes, fn(h) -> code_match?(code, h.code) end)
    |> reverse_handshakes_if_necessary(code)
  end

  defp reverse_handshakes_if_necessary(handshakes, code) do
    if code_match?(code, @reverse_code) do
      Enum.reverse(handshakes)
    else
      handshakes
    end
  end

  defp get_secrets(handshakes) do
   Enum.map(handshakes, fn(h) -> h.secret end)
  end

  defp code_match?(code, comparison_code) do
    (code &&& comparison_code) == comparison_code
  end
end

