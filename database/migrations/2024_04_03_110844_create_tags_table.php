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
        Schema::create('tags', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('comment_user_id');
            $table->foreign('comment_user_id')->references('id')->on('users')->onDelete('cascade')->comment('外鍵_留言者ID');
            $table->unsignedBigInteger('Taged_user_id');
            $table->foreign('Taged_user_id')->references('id')->on('users')->onDelete('cascade')->comment('外鍵_被Tag者ID');
            $table->foreignId('post_id')->nullable()->constrained()->onDelete('cascade')->comment('外鍵_影片ID');
            $table->foreignId('community_id')->nullable()->constrained()->onDelete('cascade')->comment('外鍵_討論ID');
            $table->foreignId('comment_id')->nullable()->constrained()->onDelete('cascade')->comment('外鍵_留言ID');
            $table->unsignedTinyInteger('viewed')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tags');
    }
};