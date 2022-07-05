describe("Jungle test", () => {
  beforeEach(() => {
    cy.visit("/");
  });

  it("visits home page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 2 products on the page", () => {
    cy.get(".products article").should("have.length", 2);
  });
});
