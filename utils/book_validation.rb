require 'date'
require 'pry'

class BookValidation

  ISBN_LENGHT = 13
  MINIMUN_LENGHT = 0

  def self.validate(book)
    validate_date(book.releasedate) &&
    validate_ISBN(book.isbn) &&
    validate_title(book.title) &&
    validate_publisher(book.publisher) &&
    validate_website(book.website)
  end

  def self.validate_date(date)
    begin
      Time.strptime(date, "%m/%d/%Y").strftime("%m/%d/%Y") == date
    rescue
      nil
    end
  end

  def self.validate_ISBN(isbn)
    isbn.length == ISBN_LENGHT
  end

  def self.validate_title(title)
    title.length > MINIMUN_LENGHT
  end

  def self.validate_publisher(publisher)
    publisher.length > MINIMUN_LENGHT
  end

  def self.validate_website(publisher)
    publisher.length > MINIMUN_LENGHT
  end
end