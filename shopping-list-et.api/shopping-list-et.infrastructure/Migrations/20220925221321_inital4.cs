using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace shopping_list_et.infrastructure.Migrations
{
    public partial class inital4 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Deleted",
                table: "Items",
                newName: "Checked");
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "Checked",
                table: "Items",
                newName: "Deleted");
        }
    }
}
