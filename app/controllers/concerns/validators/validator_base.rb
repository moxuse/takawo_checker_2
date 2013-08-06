module WiztvGameBase
  class Validators::ValidatorBase
    include ActiveModel::Model

    def validates_true?
      return true if self.errors.blank?
      return false
    end
  end
end