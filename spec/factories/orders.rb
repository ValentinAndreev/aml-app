FactoryBot.define do
  factory(:order, class: Aml::Order) do
    first_name 'First name'
    surname 'Surname'
    patronymic 'patronymic'
    birth_date Time.zone.today - 30.years
    workflow_state :none
    client
    user
  end
end
