describe("Jungle test", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("cart should increase by one after clicking the Add to Cart button", () => {
    cy.get(".products article")
      .first()
      .find("button.btn")
      .click({ force: true });
    cy.contains("a.nav-link", 1);
  });
});
