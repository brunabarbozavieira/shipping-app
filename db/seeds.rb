# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.create!(email: 'admin@sistemadefrete.com.br', password: '12345678', name: 'Administrador', user_type: 'admin')
User.create!(email: 'regular@sistemadefrete.com.br', password: 'abcdefgh', name: 'Regular', user_type: 'regular')

shipping_method_a = ShippingMethod.create!(name: 'Flash', minimum_distance: 0, maximum_distance: 30, minimum_weight: 0, maximum_weight: 300, flat_rate: 8)
Vehicle.create!(license_plate:'KBY3E32', brand:'Honda', model: 'CG 160 start', year_of_manufacture: 2019, maximum_load_capacity: 20, shipping_method: shipping_method_a)
Vehicle.create!(license_plate:'JQX8H96', brand:'Honda', model: 'CG 160 start', year_of_manufacture: 2019, maximum_load_capacity: 20, shipping_method: shipping_method_a)
Vehicle.create!(license_plate:'JZA2I45', brand:'Honda', model: 'CG 160 start', year_of_manufacture: 2019, maximum_load_capacity: 20, shipping_method: shipping_method_a)
Vehicle.create!(license_plate:'MWX8J18', brand:'Renault', model: 'Sandero', year_of_manufacture: 2020, maximum_load_capacity: 320, shipping_method: shipping_method_a)
Vehicle.create!(license_plate:'NAK9G16', brand:'Renault', model: 'Sandero', year_of_manufacture: 2020, maximum_load_capacity: 320, shipping_method: shipping_method_a)
Vehicle.create!(license_plate:'HSA8A26', brand:'Renault', model: 'Sandero', year_of_manufacture: 2020, maximum_load_capacity: 320, shipping_method: shipping_method_a)
PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.5, shipping_method: shipping_method_a)
PriceByWeight.create!(minimum_weight: 11, maximum_weight: 30, price_per_kilometer: 0.8, shipping_method: shipping_method_a)
PriceByWeight.create!(minimum_weight: 31, maximum_weight: 100, price_per_kilometer: 1.0, shipping_method: shipping_method_a)
PriceByWeight.create!(minimum_weight: 101, maximum_weight: 200, price_per_kilometer: 1.5, shipping_method: shipping_method_a)
PriceByWeight.create!(minimum_weight: 201, maximum_weight: 300, price_per_kilometer: 1.75, shipping_method: shipping_method_a)
PriceByDistance.create!(minimum_distance: 0, maximum_distance: 10, rate: 2, shipping_method: shipping_method_a)
PriceByDistance.create!(minimum_distance: 11, maximum_distance: 20, rate: 5, shipping_method: shipping_method_a)
PriceByDistance.create!(minimum_distance: 21, maximum_distance: 30, rate: 7, shipping_method: shipping_method_a)
DeliveryTime.create!(minimum_distance: 0, maximum_distance: 10, deadline_in_hours: 1, shipping_method: shipping_method_a)
DeliveryTime.create!(minimum_distance: 11, maximum_distance: 20, deadline_in_hours: 3, shipping_method: shipping_method_a)
DeliveryTime.create!(minimum_distance: 21, maximum_distance: 30, deadline_in_hours: 5, shipping_method: shipping_method_a)

shipping_method_b = ShippingMethod.create!(name: 'Express', minimum_distance: 0, maximum_distance: 1000, minimum_weight: 0, maximum_weight: 700, flat_rate: 32)
Vehicle.create!(license_plate:'MRO4H51', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method_b)
Vehicle.create!(license_plate:'KQV6B36', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800, shipping_method: shipping_method_b)
Vehicle.create!(license_plate:'MCO0A70', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method_b)
Vehicle.create!(license_plate:'NAW3J64', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800, shipping_method: shipping_method_b)
Vehicle.create!(license_plate:'FRK4A25', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method_b)
Vehicle.create!(license_plate:'MVV9B18', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800, shipping_method: shipping_method_b)
PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.30, shipping_method: shipping_method_b)
PriceByWeight.create!(minimum_weight: 11, maximum_weight: 30, price_per_kilometer: 0.45, shipping_method: shipping_method_b)
PriceByWeight.create!(minimum_weight: 31, maximum_weight: 100, price_per_kilometer: 0.75, shipping_method: shipping_method_b)
PriceByWeight.create!(minimum_weight: 101, maximum_weight: 200, price_per_kilometer: 1.15, shipping_method: shipping_method_b)
PriceByWeight.create!(minimum_weight: 201, maximum_weight: 300, price_per_kilometer: 1.35, shipping_method: shipping_method_b)
PriceByWeight.create!(minimum_weight: 300, maximum_weight: 700, price_per_kilometer: 1.65, shipping_method: shipping_method_b)
PriceByDistance.create!(minimum_distance: 0, maximum_distance: 100, rate: 9, shipping_method: shipping_method_b)
PriceByDistance.create!(minimum_distance: 101, maximum_distance: 300, rate: 12, shipping_method: shipping_method_b)
PriceByDistance.create!(minimum_distance: 301, maximum_distance: 500, rate: 15, shipping_method: shipping_method_b)
PriceByDistance.create!(minimum_distance: 501, maximum_distance: 1000, rate: 25, shipping_method: shipping_method_b)
DeliveryTime.create!(minimum_distance: 0, maximum_distance: 100, deadline_in_hours: 10, shipping_method: shipping_method_b)
DeliveryTime.create!(minimum_distance: 101, maximum_distance: 300, deadline_in_hours: 15, shipping_method: shipping_method_b)
DeliveryTime.create!(minimum_distance: 301, maximum_distance: 500, deadline_in_hours: 20, shipping_method: shipping_method_b)
DeliveryTime.create!(minimum_distance: 501, maximum_distance: 1000, deadline_in_hours: 30, shipping_method: shipping_method_b)

shipping_method_c = ShippingMethod.create!(name: 'Normal', minimum_distance: 0, maximum_distance: 1000, minimum_weight: 0, maximum_weight: 700, flat_rate: 16)
Vehicle.create!(license_plate:'KEA5D87', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method_c)
Vehicle.create!(license_plate:'NFB8A91', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800, shipping_method: shipping_method_c)
Vehicle.create!(license_plate:'MMQ4D23', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method_c)
Vehicle.create!(license_plate:'MNK8I59', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800, shipping_method: shipping_method_c)
Vehicle.create!(license_plate:'MYM9C97', brand:'Fiat', model: 'Fiorino', year_of_manufacture: 2019, maximum_load_capacity: 650, shipping_method: shipping_method_c)
Vehicle.create!(license_plate:'HLA3J12', brand:'Renault', model: 'Kangoo', year_of_manufacture: 2020, maximum_load_capacity: 800, shipping_method: shipping_method_c)
PriceByWeight.create!(minimum_weight: 0, maximum_weight: 10, price_per_kilometer: 0.10, shipping_method: shipping_method_c)
PriceByWeight.create!(minimum_weight: 11, maximum_weight: 30, price_per_kilometer: 0.30, shipping_method: shipping_method_c)
PriceByWeight.create!(minimum_weight: 31, maximum_weight: 100, price_per_kilometer: 0.50, shipping_method: shipping_method_c)
PriceByWeight.create!(minimum_weight: 101, maximum_weight: 200, price_per_kilometer: 0.80, shipping_method: shipping_method_c)
PriceByWeight.create!(minimum_weight: 201, maximum_weight: 300, price_per_kilometer: 0.90, shipping_method: shipping_method_c)
PriceByWeight.create!(minimum_weight: 300, maximum_weight: 700, price_per_kilometer: 1.0, shipping_method: shipping_method_c)
PriceByDistance.create!(minimum_distance: 0, maximum_distance: 100, rate: 5, shipping_method: shipping_method_c)
PriceByDistance.create!(minimum_distance: 101, maximum_distance: 300, rate: 9, shipping_method: shipping_method_c)
PriceByDistance.create!(minimum_distance: 301, maximum_distance: 500, rate: 12, shipping_method: shipping_method_c)
PriceByDistance.create!(minimum_distance: 501, maximum_distance: 1000, rate: 18, shipping_method: shipping_method_c)
DeliveryTime.create!(minimum_distance: 0, maximum_distance: 100, deadline_in_hours: 24, shipping_method: shipping_method_c)
DeliveryTime.create!(minimum_distance: 101, maximum_distance: 300, deadline_in_hours: 36, shipping_method: shipping_method_c)
DeliveryTime.create!(minimum_distance: 301, maximum_distance: 500, deadline_in_hours: 72, shipping_method: shipping_method_c)
DeliveryTime.create!(minimum_distance: 501, maximum_distance: 1000, deadline_in_hours: 96, shipping_method: shipping_method_c)

ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '2FE5T46YE7HCBIE', dimensions: '15cm x 5cm x 5cm', 
                     weight: 0.2, recipient_name: 'Roberto Carlos Ferreira', identification_document: '56030366050', contact_phone: '11999990000', 
                     email: 'robertocf@email.com.br', full_delivery_address: 'Rua Leonardo da Vinci, 490 - São Paulo - SP',
                     total_distance: 15)
ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '5T85YHT78EI56BD', dimensions: '104cm x 54cm x 61cm', 
                     weight: 32, recipient_name: 'Rosa de Souza Melo', identification_document: '10328832006', contact_phone: '11988880000', 
                     email: 'rosasm@email.com.br', full_delivery_address: 'Rua Frida Kahlo, 257 - Jundiaí - SP',
                     total_distance: 60)
ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '928HHR7GDBYWIJ4', dimensions: '150cm x 140cm x 18cm', 
                     weight: 200, recipient_name: 'Maria Aparecida Costa', identification_document: '94356338030', contact_phone: '11977770000', 
                     email: 'mariaapc@email.com.br', full_delivery_address: 'Rua Bela Vista, 40 - Brotas - SP',
                     total_distance: 250)
ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '03IKFHG675UY640', dimensions: '104cm x 54cm x 61cm', 
                     weight: 10, recipient_name: 'Antonio Franco', identification_document: '70281131082', contact_phone: '11966660000', 
                     email: 'antoniof@email.com.br', full_delivery_address: 'Rua Louva Deus, 222 - Curitiba - PR',
                     total_distance: 405)
ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '64YGR7UT86TERFD', dimensions: '104cm x 54cm x 61cm', 
                     weight: 90, recipient_name: 'Joao Paulo Moraes', identification_document: '33848564068', contact_phone: '11955550000', 
                     email: 'joaopm@email.com.br', full_delivery_address: 'Rua Direita, 01 - Capelinha - MG',
                     total_distance: 990)
ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: 'U786IU8TU68IUR3', dimensions: '104cm x 54cm x 61cm', 
                     weight: 4, recipient_name: 'Gabriela Martins', identification_document: '14820441027', contact_phone: '11933330000', 
                     email: 'gabrielam@email.com.br', full_delivery_address: 'Rua da Esperança, 500 - Espírito Santo do Pinhal - SP',
                     total_distance: 198)
ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '8RYHTUGHHGBFH48', dimensions: '104cm x 54cm x 61cm', 
                     weight: 0.6, recipient_name: 'José Cavalcante Neto', identification_document: '90972169075', contact_phone: '11922220000', 
                     email: 'josecn@email.com.br', full_delivery_address: 'Rua Europa, 30 - Poços de Caldas - MG',
                     total_distance: 257)
ServiceOrder.create!(initial_full_address: 'Rua Salvador Dali, 341 - São Paulo - SP', product_code: '1KIFKHU59JFN544', dimensions: '104cm x 54cm x 61cm', 
                     weight: 550, recipient_name: 'Laura Amorim', identification_document: '02457619009', contact_phone: '11911110000', 
                     email: 'lauraa@email.com.br', full_delivery_address: 'Rua das Flores, 43 - Ribeirão Preto - SP',
                     total_distance: 314)