import 'jsdom-global/register';

import chai from 'chai';

// Set chai asserts in global
global.chai = chai;
global.assert = chai.assert;
global.expect = chai.expect;
global.should = chai.should();

// Set sinon
import sinon from 'sinon';
global.sinon = sinon;
import sinonChai from 'sinon-chai';
chai.use(sinonChai);

// Set React testing (Enzyme)
import chaiEnzyme from 'chai-enzyme';
chai.use(chaiEnzyme());
