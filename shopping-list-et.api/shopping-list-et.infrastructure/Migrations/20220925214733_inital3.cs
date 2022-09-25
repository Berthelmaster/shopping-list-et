using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace shopping_list_et.infrastructure.Migrations
{
    public partial class inital3 : Migration
    {
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Items_ShoppingLists_ShoppingListId",
                table: "Items");

            migrationBuilder.AlterColumn<int>(
                name: "ShoppingListId",
                table: "Items",
                type: "int",
                nullable: false,
                defaultValue: 0,
                oldClrType: typeof(int),
                oldType: "int",
                oldNullable: true);

            migrationBuilder.AddForeignKey(
                name: "FK_Items_ShoppingLists_ShoppingListId",
                table: "Items",
                column: "ShoppingListId",
                principalTable: "ShoppingLists",
                principalColumn: "Id",
                onDelete: ReferentialAction.Cascade);
        }

        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Items_ShoppingLists_ShoppingListId",
                table: "Items");

            migrationBuilder.AlterColumn<int>(
                name: "ShoppingListId",
                table: "Items",
                type: "int",
                nullable: true,
                oldClrType: typeof(int),
                oldType: "int");

            migrationBuilder.AddForeignKey(
                name: "FK_Items_ShoppingLists_ShoppingListId",
                table: "Items",
                column: "ShoppingListId",
                principalTable: "ShoppingLists",
                principalColumn: "Id");
        }
    }
}
