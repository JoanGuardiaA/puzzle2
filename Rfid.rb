require 'ruby-nfc'
class Rfid
     #return uid in hexa str
    def read_uid
			@@readers = NFC::Reader.all
			@@readers[0].poll(Mifare::Classic::Tag) do |tag|
			
			begin
				uid = tag.uid_hex.upcase
				return uid
			end
			end
		end
end
