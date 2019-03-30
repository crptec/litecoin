#include <libethcore/Transaction.h>

class ltcEthTransaction : public dev::eth::Transaction {

 public:

     ltcEthTransaction() : nVout(0) {}

     ltcEthTransaction(dev::u256 const& _value, dev::u256 const& _gasPrice, dev::u256 const& _gas, dev::bytes const& _data, dev::u256 const& _nonce = dev::Invalid256):
		dev::eth::Transaction(_value, _gasPrice, _gas, _data, _nonce) {}

     ltcEthTransaction(dev::u256 const& _value, dev::u256 const& _gasPrice, dev::u256 const& _gas, dev::Address const& _dest, dev::bytes const& _data, dev::u256 const& _nonce = dev::Invalid256):
		dev::eth::Transaction(_value, _gasPrice, _gas, _dest, _data, _nonce) {}

     void setHashWith(const dev::h256 hash) { m_hashWith = hash; }

     dev::h256 getHashWith() const { return m_hashWith; }

     void setNVout(uint32_t vout) { nVout = vout; }

     uint32_t getNVout() const { return nVout; }

 private:

     uint32_t nVout;

};
