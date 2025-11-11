class Question < FrozenRecord::Base
  FrozenRecord::Base.base_path = "db/frozen"

  CATEGORIES = {
    emotional: "emotional",
    physical: "physical"
  }
end
