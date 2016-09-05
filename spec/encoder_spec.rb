def encode(str)
  str.rstrip.gsub!(" ", "%20")
end

RSpec.describe "#url_encoder" do
  it "replaces spaces with %20 and trims excess" do
    encoded_string = encode("Mr. John Smith   ")
    expect(encoded_string).to eq "Mr.%20John%20Smith"
  end
end
