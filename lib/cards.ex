defmodule Cards do
  @moduledoc """
  Provides methods for creating and handling a deck of cards.
  """

  @doc """
  Creates a list representing a deck of cards and returns it.

  ## Examples

      iex> Cards.create_deck()
      ["A of Clubs", "2 of Clubs", "3 of Clubs", ..., "A of Dimonds", ...]

  """
  def create_deck do
    values = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    suits = ["Clubs", "Diamonds", "Hearts", "Spade"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  Shuffle a deck of cards.
  Function has an arity (number of arguments) of 1

  ## Examples

      iex> Cards.shuffle(["Ace of Clubs", "2 of Clubs", ..., "A of Hearts", ...])
      ["7 of Spade", "A of Diamonds", "K of Hearts", ...]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Check if a card is in the deck and returns a boolean.

  ## Examples

      iex> Cards.contains?(["A of Clubs, 2 of Clubs"], "A of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Deals a hand of cards from a deck. Returns a tuple with the hand requested and the rest of the deck.

  The `hand_size` argument indicates how many cards should be in the hand.

  ## Examples

      iex> { hand, rest_of_deck } =  Cards.deal(deck, 1)
      iex> hand
      ["A of Clubs"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Save the deck into the file system
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Load deck from the file system
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist!"
    end
  end

  @doc """
  Create hand with 3 methods chained with the Pipe Operator
  """
  def create_hand(hand_size) do
    Cards.create_deck()
    |> Cards.shuffle()
    |> Cards.deal(hand_size)
  end
end
