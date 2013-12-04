# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


e1 = Event.new({ 
  user_id: 1,
  title: "Christmas Party", 
  description: "Celebrating Christmas at the Flatiron School after a 
    successful semester of Ruby, Rails and all the other good stuff 
    that comes with it.", 
  occurring_on: "2013-12-13 19:30:00", 
  location: "11 Broadway, NY NY, 10004", 
  image_url: "http://images.colourbox.com/thumb_COLOURBOX8341891.jpg", 
  slots: 50, 
  published: true, 
  public: true }).tap do |event|
    event.add_custom_fields([
      { label: "Secret Santa gift", type: "text_field" }, 
      { label: "Plus one?", type: "radio_button", options: "yes, no" }, 
      { label: "Food", type: "check_box", value: "Cookies", 
          options: "Eggnog, Cookies, Panettone, Wine, Gingerbread Beer" },
      { label: "Talent Show", type: "select", value: "Push-ups",
          options: "Singing, Dancing, Push-ups, Comedy" }
    ])
  end

e1.save
# e1.invitees.create({ name: "Manuel Neuhauser", email: "manuel@rokatu.com", 
#   phone_number: "3366550667"})
# e1.invitees.create({ name: "Vinney Cavallo", email: "vcavallo@gmail.com", 
#   phone_number: "9145526614"})
# e1.invitees.create({ name: "Jai-Lee Egna", email: "jailee.egna@gmail.com" })
# e1.invitees.create({ name: "Mooskers The Cat", phone_number: "9175438327"})

# e1.registrations.first.update({ price: 0, name: "Josh Scaglione", 
#   email: "josh@scagmail.com", finalized: true})
# e1.registrations.last.update({ name: "Avi Flombaum", email: "me@avi.com", 
#   finalized: true })
