struct VoucherMath {
    static func redeem(points value: Int) -> Int { value / 2 }
}
func sample() -> Int { VoucherMath.redeem(points: 18) }
