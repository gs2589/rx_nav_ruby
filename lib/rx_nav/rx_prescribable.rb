module RxNav
  class RxPrescribable
    class << self
      def all_concepts
        query = "/allconcepts"
        data = get_response_hash(query)[:min_concept_group]
        return data.map{ |c| RxNav::Concept.new(c) }
      end

      def get_concept_ndcs rxcui
        rxcui=rxcui.to_s
        query="/rxcui/#{rxcui}/ndcs"
        ndc_list=get_response_hash(query)[:ndc_group][:ndc_list]
        ndc_list ? ndc_list[:ndc] : nil
      end

      def all_info id
        query = "/rxcui/#{id}/allinfo"
        data = get_response_hash(query)[:rxterms_properties]
        return RxNav::Concept.new(data)
      end

      private

      def get_response_hash query
        RxNav.make_request('/Prescribe' + query)[:rxtermsdata]
      end
    end
    
    self.singleton_class.send(:alias_method, :get_info, :all_info)

  end
end