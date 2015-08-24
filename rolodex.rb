require_relative('contact.rb')

class Rolodex
  @@id = 1000

  def initialize
    @contacts = []
  end

  def add_contact(first_name, last_name, email, note)
    contact = Contact.new(@@id, first_name, last_name, email, note)
    @@id += 1

    @contacts << contact
  end

  def change_contact(id, first_name, last_name, email, note)
    @contacts.delete_at(id)

    id2 = id + 1000

    contact = Contact.new(id2, first_name, last_name, email, note)
    @contacts.insert(id, contact)
  end

  def delete_contact(id)
    @contacts.delete_at(id)
  end

  def all
    @contacts
  end
end