require './quicksort'

describe 'quick sort' do
  it 'should sort an array' do
    expect(quicksort([10, 5, 2, 3])).to eq [2, 3, 5, 10]
  end
end
