import React from 'react';
import Sample from 'example/sample';
import {mount} from 'enzyme';

describe('Sample', function() {
  describe('#render()', function() {
    let wrapper = mount(<Sample />);

    it('by default should have #checked checked', function() {
      expect(wrapper.find('#checked')).to.be.checked();
    });
    it('by default should have #not not checked', function() {
      expect(wrapper.find('#not')).to.not.be.checked();
    });
  });
});
