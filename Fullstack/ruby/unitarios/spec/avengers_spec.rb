class AvengersHeadQuarter
    attr_accessor :list

    def initialize
        self.list = []
    end

    def put(avenger)
        self.list.push(avenger)
    end
end

describe AvengersHeadQuarter do

    it 'deve adicionar um vingador' do
        hq = AvengersHeadQuarter.new

        hq.put('Spiderman')
        expect(hq.list).to include 'Spiderman'
    end

    it 'deve adicionar uma lista de vingadores' do
        hq = AvengersHeadQuarter.new
        hq.put('Thor')
        hq.put('Hulk')
        hq.put('Capitao')

        res = hq.list.size > 0

        expect(hq.list.size).to be > 0
        expect(res).to be true
    end

    it 'thor deve ser o primeiro da lista' do 
        hq = AvengersHeadQuarter.new
        hq.put('Thor')
        hq.put('Hulk')
        hq.put('Capitao')

        expect(hq.list).to start_with('Thor')
    end

    it 'iroman deve ser o ultimo da lista' do
        hq = AvengersHeadQuarter.new
        hq.put('Thor')
        hq.put('Hulk')
        hq.put('Iroman')

        expect(hq.list).to end_with('Iroman')
     end

    it 'deve conter o sobrenome' do
        avenger = 'Peter Parker'

        expect(avenger).to match (/Parker/)
        expect(avenger).not_to match (/Jeff/)
    end

    it 'deve conter duas listas iguais' do
        carro1 = 'monza', 'passat', 'escort'
        carro2 = 'monza', 'passat', 'escort'
        
        expect(carro1).to eq(carro2)
    end
end