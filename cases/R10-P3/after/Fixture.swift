struct VoucherMath {
    static func redeem(_ value: Int) -> Int { value / 2 }
}
func sample() -> Int { VoucherMath.redeem(18) }
