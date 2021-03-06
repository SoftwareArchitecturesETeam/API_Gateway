class ManagePlacesController < ApplicationController
    USERS_MS = "http://ms-users.ms-users:3000/"
    PLACES_MS = "http://ms-events-and-places.ms-events-and-places:3000/"

    def getPlaces
        result = HTTParty.get(PLACES_MS + "places")
        if result.code == 200
            render json: {
                sites: JSON.parse(result.body),
            }, status: :ok
        else
            render json: {
                message: "Ocurrió un error al obtener los sitios",
                errors: JSON.parse(result.body),
            }, status: :bad_request
        end
    end

    def get_Places_By_Id(id)
         result = HTTParty.get(EVENTS_MS + "places/" + id.to_s)
         if result.code == 200
             return result
         else
             render json: {
                 message: "El sitio con id: " + id.to_s + "no existe",
                 token: current_user.header['jwt']
             }, status: :unauthorized
         end
     end

end
