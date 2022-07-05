describe("Jungle test", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("when clicking .products article, redirect to the proudct page", () => {
    cy.get("article:nth-child(1) a").click();
    cy.url().should("include", "products/");
  });
});
