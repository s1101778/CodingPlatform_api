<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('comments', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade')->comment('外鍵_使用者ID');
            $table->unsignedBigInteger('parent_comment_id')->nullable();
            $table->foreign('parent_comment_id')->references('id')->on('comments')->onDelete('cascade')->comment('外鍵_父comment_id');
            $table->integer('children_comment_count')->default(0);
            $table->foreignId('post_id')->nullable()->constrained()->onDelete('cascade')->comment('外鍵_影片ID');
            $table->foreignId('community_id')->nullable()->constrained()->onDelete('cascade')->comment('外鍵_討論ID');
            $table->text('content');
            $table->integer('likes')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('comments');
    }
};