class Validators::ValidationEntry < Validators::ValidatorBase
  attr_accessor :query
  validates :query, :presence => { :message => "文字数が入ってないです" }
  validates :query, :length => { :minimum => 2, :message => "文字数が少な過ぎます"}
  validate :query_f_word?

  def query_f_word?
    return true unless f_word.include?(query)
    errors.add(:query, '禁止ワードです') 
  end


  def f_word
    [ "takawo", "#", "杯", "@"]
  end

end
