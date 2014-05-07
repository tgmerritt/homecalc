class Loan
  include MongoMapper::Document

  key :bank_name, String
  key :postal_code, String
  key :price, Float, :default => 0
  key :down_pmt_percent, Float, :default => 0
  key :term, Integer, :default => 0
  key :interest_rate, Float, :default => 0
  key :apr, Float, :default => 0
  key :down_pmt, Float, :default => 0
  key :annual_prop_tax, Float, :default => 0
  key :annual_insurance, Float, :default => 0
  key :annual_maintenance, Float, :default => 0
  key :annual_improvements, Float, :default => 0
  key :income_tax_rate, Float, :default => 0
  key :hoa_dues, Float, :default => 0
  key :third_party_fees, Float, :default => 0
  key :lender_fees, Float, :default => 0
  key :escrow, Float, :default => 0
  timestamps!

end
