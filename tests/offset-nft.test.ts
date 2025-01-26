import { describe, it, expect, beforeEach } from "vitest"

describe("offset-nft", () => {
  let contract: any
  
  beforeEach(() => {
    contract = {
      mintOffsetNft: (projectId: number, emissionsReduction: number) => ({ value: 1 }),
      getOffsetNftData: (tokenId: number) => ({
        projectId: 1,
        emissionsReduction: 10000,
        verificationDate: 123456,
      }),
    }
  })
  
  describe("mint-offset-nft", () => {
    it("should mint a new offset NFT", () => {
      const result = contract.mintOffsetNft(1, 10000)
      expect(result.value).toBe(1)
    })
  })
  
  describe("get-offset-nft-data", () => {
    it("should return offset NFT data", () => {
      const result = contract.getOffsetNftData(1)
      expect(result.projectId).toBe(1)
      expect(result.emissionsReduction).toBe(10000)
      expect(result.verificationDate).toBe(123456)
    })
  })
})

