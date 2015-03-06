class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :definir_usuario

  #un Usuario tiene muchas ventas
  has_many :venta

  #validaciones:
  validates :email, presence: true, uniqueness: true

  validates :nombre, presence: true
  validates :apellido, presence: true
  validates :email, presence: true, uniqueness:true

  def definir_usuario
    usuario = Usuario.find(self.id)
    usuario.tipo_usuario = 0
    usuario.save!
  end

end
