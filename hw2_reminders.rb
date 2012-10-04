#File: ar_test.rb 
#Author: Michael Darling
#ECE595 Homework 2

require "active_record"

#Adapter for the SQLite3 
ActiveRecord::Base::establish_connection(:adapter => "sqlite3",
	:database => "reminderdb.sqlite")

#Define database schema, and create database "reminders" 
class ReminderTableScript < ActiveRecord::Migration

  def self.up
    create_table :reminders do | t |
      t.text :task
      t.date :due_date
      t.boolean :is_complete
    end
end

  def self.down 
    drop_table :reminders
  end 
end

#Create the table that will be used in the database 
ReminderTableScript.up


class Reminder < ActiveRecord::Base 

  def initialize( task, due_date)
    super()		
    self.task = task
    self.due_date = due_date
    self.is_complete = false
    self.save
  end
 
  def set_task task
    self.task = task
    self.save		
  end

  def set_date due_date
    self.due_date = due_date
    self.save
  end

  def set_complete
    self.is_complete = true
  end

end

def all
  Reminder.find(:all)
end

def due_today
  Reminder.find(:all, :conditions => [ "due_date = ?", Date.today])
end




