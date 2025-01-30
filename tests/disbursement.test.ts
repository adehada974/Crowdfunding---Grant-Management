import { describe, it, beforeEach, expect } from "vitest"

describe("disbursement", () => {
  let contract: any
  
  beforeEach(() => {
    contract = {
      getDisbursement: (campaignId: number, milestoneId: number) => ({ amount: 300, status: "pending" }),
      requestDisbursement: (campaignId: number, milestoneId: number, amount: number) => ({ success: true }),
      approveDisbursement: (campaignId: number, milestoneId: number) => ({ success: true }),
    }
  })
  
  describe("get-disbursement", () => {
    it("should return disbursement information", () => {
      const result = contract.getDisbursement(1, 1)
      expect(result.amount).toBe(300)
      expect(result.status).toBe("pending")
    })
  })
  
  describe("request-disbursement", () => {
    it("should request disbursement", () => {
      const result = contract.requestDisbursement(1, 1, 300)
      expect(result.success).toBe(true)
    })
  })
  
  describe("approve-disbursement", () => {
    it("should approve disbursement", () => {
      const result = contract.approveDisbursement(1, 1)
      expect(result.success).toBe(true)
    })
  })
})

