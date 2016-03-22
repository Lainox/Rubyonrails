class Post < ActiveRecord::Base

	FOTOS = File.join Rails.root, 'public', 'photo_store'
	after_save :guardar_foto

	def photo=(file_data) #es la imagen que nos envia el form
		
		unless file_data.blank? #si file_data no esta vacio ejecuta lo de abajo
			@file_data = file_data
			#self hace referencia al campo de la bd que estamos trabajando
			self.extension = file_data.original_filename.split('.').last.downcase
		end
	end
	def photo_filename
		#Ahora creamos una ruta. Va a retornarla
		File.join FOTOS, "#{id}.#{extension}"
	end
	def photo_path
		"/photo_store/#{id}.#{extension}"
	end	
	def has_photo?
		File.exists? photo_filename
	end	
	private

	def guardar_foto
       if @file_data
       		FileUtils.mkdir_p FOTOS
       		File.open(photo_filename, 'wb') do |f|
       			f.write(@file_data.read)
       		end
       		@file_data = nil
       	end
	end
end
