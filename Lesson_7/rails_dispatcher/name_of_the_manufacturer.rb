module NameManufacturer
  attr_writer :name_company

  def name_company
    if @name_company.nil?
      puts 'У этого обьекта нет  компании-производителя'
    else
      puts "Производитель этого обьекта #{@name_company}"
    end
  end
end
