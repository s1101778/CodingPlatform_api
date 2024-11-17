<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('user_likes', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade')->comment('外鍵_使用者ID');
            $table->foreignId('post_id')->nullable()->constrained()->onDelete('cascade')->comment('外鍵_影片ID');
            $table->foreignId('community_id')->nullable()->constrained()->onDelete('cascade')->comment('外鍵_討論ID');
            $table->foreignId('comment_id')->nullable()->constrained()->onDelete('cascade')->comment('外鍵_留言ID');
            $table->integer('dislike_or_like');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_likes');
    }
};
