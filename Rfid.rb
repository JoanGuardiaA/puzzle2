require 'ruby-nfc'
class Rfid
	@@readers = NFC::Reader.all
    	#return uid in hexa str
   	def read_uid
		@@readers[0].poll(Mifare::Classic::Tag) do |tag|
		uid = tag.uid_hex.upcase
		return uid
		end
	end
end
