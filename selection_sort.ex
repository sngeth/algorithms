# Selection sort is O(n^2) algorithm suitable only for small sets
# We have to use Elixir's list processing capabilities instead of iterating with a for loop

# The classic way of processing a list is to process the head of an item and make a
# recursive call with the remaining list with a base case to end the recursion.

# The main give away that this is a O(n^2) algorithm is the nested iteration.
# The outer processing iterates through the entire list and within each pass
# we must do another iteration to find the minimum from that sublist.

defmodule Selection do
  # kick off the sort by passing the original list and empty accumulator list
  def sort(list) when is_list(list) do
    do_selection(list, [])
  end

  # base case
  def do_selection([head | []], acc) do
    # when no more items to process add last item to accumulated sorted list
    acc ++ [head]
  end

  # while we have items to process
  def do_selection(list, acc) do
    # bind the current mininum of the list
    min = min(list)
    # recursively call and pop off current minimum item and add that item to the accumulator
    do_selection(List.delete(list, min), acc ++ [min])
  end

  # base case for finding minimum
  defp min([first | [second | [] ]]) do
    smaller(first, second)
  end

  # find the minimum of the list
  defp min([first | [second | tail]]) do
    # find the minimum between the first item of list and second
    min([smaller(first, second) | tail]) # pass the rest of the list and call recursively
  end

  defp smaller(e1, e2) do
    if e1 <= e2 do e1 else e2 end
  end
end

IO.inspect Selection.sort([3,1,5,4,2])
