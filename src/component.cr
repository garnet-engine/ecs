abstract struct Garnet::Component
  macro inherited
    def self.to_sym
      :{{ @type.name.id.stringify.camelcase.gsub(/:/, "_").id }}
    end

    class ::Garnet::Entity
      def all_with_component(klass : {{ @type.name.id.stringify.camelcase.id }}.class)
        children.select { |e| e[{{ @type.name.id.stringify.camelcase.id }}]? }
      end

      def [](klass : {{ @type.name.id.stringify.camelcase.id }}.class)
        %component = components[{{ @type.name.id }}.to_sym]
        case %component
        when {{ @type.name.id }}
          %component
        else
          raise "???"
        end
      end

      def []?(klass : {{ @type.name.id.stringify.camelcase.id }}.class)
        %component = components[{{ @type.name.id }}.to_sym]?
        case %component
        when nil
          nil
        when {{ @type.name.id }}
          %component
        else
          raise "???"
        end
      end

      def delete(klass : {{ @type.name.id.stringify.camelcase.id }})
        delete(klass.class)
      end
      def delete(klass : {{ @type.name.id.stringify.camelcase.id }}.class)
        components.delete({{ @type.name.id }}.to_sym)
      end

      def has_component?(klass : {{ @type.name.id.stringify.camelcase.id }}.class)
        %component = self[{{ @type.name.id }}.to_sym]?
        case %component
        when nil
          false
        when {{ @type.name.id }}
          true
        else
          raise "???"
        end
      end
    end
  end
end
