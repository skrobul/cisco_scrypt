# frozen_string_literal: true

HASHES = [
  {
    password: "cisco",
    salt: "nhEmQVczB7dqsO",
    hash: "$9$nhEmQVczB7dqsO$X.HsgL6x1il0RxkOSSvyQYwucySCt7qFm4v7pqCxkKM"
  },
  {
    password: "hashcat",
    salt: "2MJBozw/9R3UsU",
    hash: "$9$2MJBozw/9R3UsU$2lFhcKvpghcyw8deP25GOfyZaagyUOGBymkryvOdfo6"
  },
  {
    password: "123456",
    salt: "cvWdfQlRRDKq/U",
    hash: "$9$cvWdfQlRRDKq/U$VFTPha5VHTCbSgSUAo.nPoh50ZiXOw1zmljEjXkaq1g"
  },
  {
    password: "JtR",
    salt: "X9fA8mypebLFVj",
    hash: "$9$X9fA8mypebLFVj$Klp6X9hxNhkns0kwUIinvLRSIgWOvCwDhVTZqjsycyU"
  },
  {
    password: "videgro",
    salt: "salt",
    hash: "$9$salt$mwoksv.VaKEzdcytBnQMWWnpDLjfbMSJb6Rp9r8nAWY"
  }
].freeze

RSpec.describe CiscoScrypt do
  it "has a version number" do
    expect(CiscoScrypt::VERSION).not_to be nil
  end

  describe ".generate" do
    HASHES.each do |entry|
      it "generates hash for #{entry[:password]}" do
        expect(CiscoScrypt.generate(entry[:password], entry[:salt]))
          .to eq entry[:hash]
      end
    end
  end
end
