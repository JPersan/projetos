const expect = require('chai').expect;
const { I } = inject();

Feature('people');

Scenario('verifica status chamada', async () => {
    const res = await I.sendGetRequest('/api/people/1/');
    expect(res.status).to.eql(200);
});

Scenario('verifica campos', async () => { 
    const res = await I.sendGetRequest('/api/people/1/');
    expect(res.data.name).to.eql('Luke Skywalker')
    expect(res.data.height).to.eql('172')
    expect(res.data.mass).to.eql('77')
    expect(res.data.hair_color).to.eql('blond')
    expect(res.data.skin_color).to.eql('fair')
    expect(res.data.eye_color).to.eql('blue')
    expect(res.data.birth_year).to.eql('19BBY')
    expect(res.data.gender).to.eql('male')
});
