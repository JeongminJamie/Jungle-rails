describe("Jungle test", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("when clicking .products article, redirect to the proudct page", () => {
    cy.get(".products article").first().click();
    cy.url().should("include", "products/");
  });
});
