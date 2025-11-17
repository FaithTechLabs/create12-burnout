class Question < FrozenRecord::Base
  FrozenRecord::Base.base_path = "db/frozen"

  CATEGORIES = {
    emotional: "Emotional",
    physical: "Physical",
    mental: "Mental",
    spiritual: "Spiritual",
    relational: "Relational",
    professional: "Professional"
  }
end
