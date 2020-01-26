require "net/http"
require "uri"
require "rexml/document"

namespace :currency do
  desc 'Сохранить курсы валют'
  task :save_exchange_rates => :environment do
    begin
      document
      document.root.elements.each do |currency|
        name = currency.get_text('Name')
        rate = currency.get_text('Value')

        obj = Currency.new(name: name, rate: rate)
        obj.save
      end
      puts "Курсы валют успешно сохранены!"
    rescue => e
      puts "Курсы валют не сохранены! #{e.message}"
    end
  end

  desc 'Обновить курсы валют'
  task :update_exchange_rates => :environment do
    begin
      document
      document.root.elements.each do |currency|
        name = currency.get_text('Name')
        rate = currency.get_text('Value')

        currency_exchange = Currency.find_by_name(name.to_s)
        currency_exchange.update!(name: name, rate: rate)
      end
      puts "Курсы валют успешно обновлены!"
    rescue => e
      puts "Курсы валют не обновлены! #{e.message}"
    end
  end

  def document
    uri = URI.parse("http://www.cbr.ru/scripts/XML_daily.asp")
    response = Net::HTTP.get_response(uri)
    document = REXML::Document.new(response.body)
  end
end
