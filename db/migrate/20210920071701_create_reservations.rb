class CreateReservations < ActiveRecord::Migration[6.1]
  def change
    create_table :reservations do |t|
      t.belongs_to :guest, null: false, foreign_key: true

      t.string     :reservation_code, uniq: true
      t.datetime   :start_date
      t.datetime   :end_date
      t.integer    :nights
      t.integer    :guests
      t.integer    :children
      t.integer    :adults
      t.integer    :infants
      t.integer    :status
      t.string     :currency, default: "AUD"
      t.decimal    :payout_price, precision: 8, scale: 2
      t.decimal    :security_price, precision: 8, scale: 2
      t.decimal    :total_price, precision: 8, scale: 2


      t.timestamps
    end
  end
end
