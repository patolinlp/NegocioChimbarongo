class Cliente < ActiveRecord::Base

	filterrific(  available_filters:[
	    :with_rut
	])

	scope :with_rut, lambda { |ref_rut|
		where(:rut => [ref_rut])
	}

end
