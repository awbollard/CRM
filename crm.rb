require_relative ('rolodex.rb')

class CRM
  attr_accessor :title

  def self.run(name)
    crm = new(name)
    crm.main_menu
  end

  def initialize(name)
    @title = name
    @rolodex = Rolodex.new
  end

  def print_main_menu
    puts "1. Add a contact"
    puts "2. Modify a contact"
    puts "3. Display all contacts"
    puts "4. Display contact"
    puts "5. Display contact attribute"
    puts "6. Delete a contact"
    puts "7. Exit"
  end

  def main_menu
    while true
      print_main_menu
      print "Choose an option: "
      user_input = gets.chomp.to_i
      break if user_input == 7
      choose_option(user_input)
    end
  end

  def choose_option(input)
    # input = user_input
    case input
    when 1 then add_contact
    when 2 then modify_contact
    when 3 then display_all_contacts
    when 4 then display_contact
    when 5 then display_contact_attribute
    when 6 then delete_contact
    when 7 then exit
    else
      puts "I'm sorry Dave, I'm afraid you can't do that."
    end
  end

  def add_contact
    print "First name: "
    first_name = gets.chomp

    print "Last name: "
    last_name = gets.chomp

    print "Email: "
    email = gets.chomp

    print "Notes: "
    notes = gets.chomp

    @rolodex.add_contact(first_name, last_name, email, notes)
  end

  def modify_contact
    puts "Which contact would you like to modify? Enter ID number: "
    id = gets.chomp.to_i

    id -= 1000

    current_contact = @rolodex.all.fetch(id)

    puts "What would you like changed?"
    puts "1. First name: #{current_contact.first_name}"
    puts "2. Last name: #{current_contact.last_name}"
    puts "3. Email: #{current_contact.email}"
    puts "4. Notes: #{current_contact.notes}"
    num = gets.chomp.to_i

    puts "Enter new entry here: "
    change = gets.chomp.to_s

    case num
    when 1 then @rolodex.change_contact(id, change, current_contact.last_name, current_contact.email, current_contact.notes)
    when 2 then @rolodex.change_contact(id, current_contact.first_name, change, current_contact.email, current_contact.notes)
    when 3 then @rolodex.change_contact(id, current_contact.first_name, current_contact.last_name, change, current_contact.notes)
    when 4 then @rolodex.change_contact(id, current_contact.first_name, current_contact.last_name, current_contact.email, change)
    else puts "Entry was not valid"
    end    
  end

  def display_all_contacts
    @rolodex.all.each do |contact|
      puts "#{contact.id}: #{contact.full_name} / #{contact.email}"
    end
  end

  def display_contact
    puts "Which contact would you like displayed? Enter ID number: "
    id = gets.chomp.to_i

    id -= 1000

    current_contact = @rolodex.all.fetch(id)

    puts "First name: #{current_contact.first_name}"
    puts "Last name: #{current_contact.last_name}"
    puts "Email: #{current_contact.email}"
    puts "Notes: #{current_contact.notes}"
  end

  def display_contact_attribute
    puts "Which contact would you like displayed? Enter ID number: "
    id = gets.chomp.to_i

    id -= 1000

    current_contact = @rolodex.all.fetch(id)

    puts "Which attribute would you like to see?"
    puts "1. First Name"
    puts "2. Last Name"
    puts "3. Email"
    puts "4. Notes"
    attr_num = gets.chomp.to_i

    attr_num -= 1

    case attr_num
    when 0 then puts current_contact.first_name
    when 1 then puts current_contact.last_name
    when 2 then puts current_contact.email
    when 3 then puts current_contact.notes
    else puts "Not valid."
    end    
  end

  def delete_contact
    puts "Which contact would you like deleted? Enter ID number: "
    id = gets.chomp.to_i

    id -= 1000

    @rolodex.delete_contact(id)
  end
end


CRM.run("Bitmaker Labs CRM")